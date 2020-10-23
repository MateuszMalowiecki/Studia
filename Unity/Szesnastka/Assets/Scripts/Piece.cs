﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Piece : MonoBehaviour
{
    [HideInInspector]
    public bool clicked=false;
    [HideInInspector]
    public bool go_left;
    [HideInInspector]
    public bool go_right;
    [HideInInspector]
    public bool go_up;
    [HideInInspector]
    public bool go_down;
    [HideInInspector]
    public bool moved;
    [HideInInspector]
    public Vector3 winPosition;
    // Start is called before the first frame update
    void Start()
    {
        winPosition=transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        movePuzzle();
    }
    private void OnMouseDown() {
        clicked = true;
    } 
    private void OnMouseUp() {
        clicked = false;
        moved=false;
    }
    void movePuzzle() {
        if (go_right) {
            transform.position += 6*Vector3.right;
            go_right = false;
            moved=true;
        }
        if (go_left) {
            transform.position += 6*Vector3.left;
            go_left = false;
            moved=true;
        }
        if (go_up) {
            transform.position += 6*Vector3.forward;
            go_up = false;
            moved=true;
        }
        if (go_down) {
            transform.position += 6*Vector3.back;
            go_down = false;
            moved=true;
        }
    }
}
