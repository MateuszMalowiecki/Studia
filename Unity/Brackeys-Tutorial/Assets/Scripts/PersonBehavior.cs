using UnityEngine;

public class PersonBehavior : MonoBehaviour
{
    public Rigidbody rb;
    public Transform playerpos;
    public float forwardForce=200f;
    public float sidewaysForce=200f;
    
    // Update is called once per frame
    void Update() {
        if (playerpos.position.y < 1.5) {
            rb.AddForce(0, 0, forwardForce * Time.deltaTime);
        }
        if(Input.GetKey("d"))
        {
            rb.AddForce(sidewaysForce * Time.deltaTime, 0, 0, ForceMode.VelocityChange);
        }
        if (Input.GetKey("a"))
        {
            rb.AddForce(-sidewaysForce * Time.deltaTime, 0, 0, ForceMode.VelocityChange);
        }
        if (rb.position.y < -1f)
        {
            FindObjectOfType<GameManager>().EndGame();
        }
    }
}
