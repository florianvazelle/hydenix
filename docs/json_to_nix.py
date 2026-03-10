#!/usr/bin/env python3

import json
import sys


def insert(tree, path, opt):
    node = tree
    for part in path[:-1]:
        node = node.setdefault(part, {})
    node[path[-1]] = opt


def build_tree(options):
    tree = {}
    for opt in options:
        insert(tree, opt["name"].split("."), opt)
    return tree


def is_leaf(v):
    return isinstance(v, dict) and "name" in v


def normalize(v):
    if v is None:
        return "null"

    v = str(v).strip()

    # collapse short arrays to one line
    if v.startswith("[") and "\n" in v:
        items = [x.strip() for x in v.strip("[]").split("\n") if x.strip()]
        if len(items) <= 6:
            return "[ " + " ".join(items) + " ]"

    return v


def leaf_count(node):
    count = 0
    for v in node.values():
        if is_leaf(v):
            count += 1
        else:
            count += leaf_count(v)
    return count


def sorted_keys(node):
    keys = sorted(node.keys())

    # enable first
    if "enable" in keys:
        keys.remove("enable")
        keys = ["enable"] + keys
    
    # hm last
    if "hm" in keys:
        keys.remove("hm")
        keys = keys + ["hm"]

    return keys


def render(node, indent=0):
    space = "  " * indent

    for key in sorted_keys(node):
        val = node[key]

        if is_leaf(val):
            default = normalize(val.get("default_value"))
            desc = val.get("description", "")

            print(f"{space}{key} = {default}; # {desc}")
            continue

        # collapse subtree if only one leaf
        if leaf_count(val) == 1:
            k, v = next(iter(val.items()))
            default = normalize(v.get("default_value"))
            desc = v.get("description", "")

            print(f"{space}{key}.{k} = {default}; # {desc}")
            continue

        print(f"{space}{key} = {{")
        render(val, indent + 1)
        print(f"{space}}};")


def main():
    if len(sys.argv) != 2:
        print("usage: json_to_nix.py options.json")
        sys.exit(1)

    with open(sys.argv[1]) as f:
        data = json.load(f)

    tree = build_tree(data)

    render(tree)


if __name__ == "__main__":
    main()