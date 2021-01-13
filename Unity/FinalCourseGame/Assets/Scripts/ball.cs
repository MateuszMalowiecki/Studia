using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ball : MonoBehaviour {
    public float ballInitialVelocity;
    private Rigidbody rb;
    private bool ballInPlay = false;
    // Start is called before the first frame update
    void Awake() {
        rb = GetComponent<Rigidbody>();
        ballInitialVelocity = 300.0f;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown("space") && !ballInPlay) {
            transform.parent=null;
            ballInPlay = true;
            rb.isKinematic=false;
            //rb.useGravity=true;
            rb.AddForce(new Vector3(ballInitialVelocity, ballInitialVelocity, 0));
        }
    }
}
