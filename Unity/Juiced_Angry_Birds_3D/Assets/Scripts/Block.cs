using UnityEngine;

public class Block : MonoBehaviour {
    public GameObject blockBoom;
    public CameraShake cameraShake;
    void OnCollisionEnter(Collision colInfo) {
        if((colInfo.collider.name == "Ground" || colInfo.collider.name == "Ball3D" 
        || colInfo.collider.name == "Ball3D (1)")  
        && colInfo.relativeVelocity.magnitude > 6.0f) {
            Score.points+=30;
            StartCoroutine(cameraShake.shake(0.35f, 0.4f));
            FindObjectOfType<Audiomanager>().Play("Boom");
            Instantiate(blockBoom, transform.position, Quaternion.identity);
            Destroy(gameObject);
        }
    }
}
