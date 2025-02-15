class_name Utilities
extends Node

# function from personnal toolbox : find first child of given type from parent.
static func find_first_child_of_type(parent, type, depth:int=0)->Node:
    for child in parent.get_children():
        if is_instance_of(child, type):
            return child
        # ---
        var grandchild = find_first_child_of_type(child, type, depth+1)
        if is_instance_valid(grandchild):
            return grandchild
    # ---
    if depth==0:
        push_warning("no child found of type : ", type)
    return null


static  func find_first_parent_of_type(node:Node, type)->Node:
    var parent :Node= node.get_parent()
    if is_instance_of(parent, type):
        return parent
    elif parent == node.get_tree().root:
        push_warning("no parent found to root")
        return null
    # ---
    return find_first_parent_of_type(parent, type)
