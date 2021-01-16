using System.Collections;
using UnityEngine;

public class ball : MonoBehaviour {
    public float ballInitialVelocity;
    Renderer rend;
    public Material[] mats;
    private Rigidbody rb;
    private bool ballInPlay = false;
    // Start is called before the first frame update
    void Awake() {
        rend = GetComponent<Renderer>();
        rend.enabled=true;
        rb = GetComponent<Rigidbody>();
        ballInitialVelocity = 300.0f;
    }

    // Update is called once per frame
    void Update() {
        if (Input.GetKeyDown("space") && !ballInPlay) {
            transform.parent=null;
            ballInPlay = true;
            rb.isKinematic=false;
            rb.AddForce(new Vector3(ballInitialVelocity, ballInitialVelocity, 0));
        }
        if (ballInPlay && rb.velocity.x == 0) {
            rb.AddForce(new Vector3(10.0f, 0, 0));
        }
        if (ballInPlay && rb.velocity.y == 0) {
            rb.AddForce(new Vector3(0, -10.0f, 0));
        }
    }
    IEnumerator OnCollisionEnter(Collision colInfo) {
        StartCoroutine(FindObjectOfType<CameraShake>().shake(0.1f, 0.2f));
        transform.localScale = new Vector3(transform.localScale.x * 1.5f, transform.localScale.y*1.5f,  transform.localScale.z*1.5f);
        rend.sharedMaterial=mats[1];
        yield return new WaitForSeconds(0.1f);
        transform.localScale = new Vector3(transform.localScale.x / 1.5f, transform.localScale.y/1.5f,  transform.localScale.z/1.5f);
        rend.sharedMaterial=mats[0];
    }
}
