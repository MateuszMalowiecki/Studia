using System.Collections;
using UnityEngine;

public class paddle : MonoBehaviour
{
    public float paddleSpeed = 1f;
    private Vector3 playerPos = new Vector3(0, -1f, 0);
    // Update is called once per frame
    void Update() {
       float xPos=transform.position.x + (Input.GetAxis("Horizontal") * paddleSpeed);
       playerPos=new Vector3(Mathf.Clamp(xPos, -8.5f, 8.5f), -1f, 0);
       transform.position = playerPos;
    }

}
