using System.Collections;
using UnityEngine;

public class Bricks : MonoBehaviour {
    public GameObject brickParticle;
    void OnCollisionEnter(Collision other) {
        Instantiate(brickParticle, transform.position, Quaternion.identity);
        GameManager.instance.DestroyBrick();
        Destroy(gameObject);
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
