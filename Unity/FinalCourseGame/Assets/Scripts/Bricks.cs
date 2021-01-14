using System.Collections;
using UnityEngine;

public class Bricks : MonoBehaviour {
    public GameObject brickParticle;
    public GameObject nextBrick;
    public int hitPoints=1;
    void OnCollisionEnter(Collision other) {
        this.hitPoints--;
        if (hitPoints == 0) {
            Instantiate(brickParticle, transform.position, Quaternion.identity);
            Destroy(gameObject);
            GameManager.instance.DestroyBrick();
        }
        else{
            Instantiate(nextBrick, transform.position, Quaternion.identity);
            Destroy(gameObject);
        }
    }
}
