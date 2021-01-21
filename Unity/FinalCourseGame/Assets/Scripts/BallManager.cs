using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallManager : MonoBehaviour
{
    public static BallManager instance =null;
    public List<ball> balls {get; set;}
    public GameObject ballPrefab;
    // Start is called before the first frame update
    void Start() {
        if (instance == null) {
            instance = this;
        }
        else if (instance != this) {
            Destroy(gameObject);
        }
        balls=new List<ball>();
    }
    
    public void SpawnBalls(Vector3 position) {
        for (int i = 0; i < 2; i++) {
            ball spawnedBall = Instantiate(ballPrefab, position, Quaternion.identity).GetComponent<ball>();
            spawnedBall.gameObject.transform.localScale= new Vector3(spawnedBall.gameObject.transform.localScale.x, spawnedBall.gameObject.transform.localScale.y / 3, spawnedBall.gameObject.transform.localScale.z / 3);
            this.balls.Add(spawnedBall);
            Rigidbody spawnedBallRb = spawnedBall.GetComponent<Rigidbody>();
            spawnedBallRb.isKinematic = false;
            spawnedBallRb.AddForce(new Vector2(0, spawnedBall.ballInitialVelocity));
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
