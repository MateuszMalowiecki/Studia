using UnityEngine;

public class PlayerCollision : MonoBehaviour
{
    public PersonBehavior movement;
    public GameManager gm;
    void OnCollisionEnter(Collision collisioninfo)
    {
        if (collisioninfo.collider.tag == "Obstacle")
        {
            movement.enabled = false;
            FindObjectOfType<GameManager>().EndGame();
        }
    }
}
