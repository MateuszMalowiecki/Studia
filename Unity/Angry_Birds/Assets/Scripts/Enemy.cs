using UnityEngine;
using UnityEngine.SceneManagement;

public class Enemy : MonoBehaviour {
    public GameObject deathEffect;
    public static int  EnemiesAlive = 0;
    public float health=4f;
    // Start is called before the first frame update
    void Start() {
        EnemiesAlive++;
    }
    void OnCollisionEnter2D(Collision2D colInfo) {
        if (colInfo.relativeVelocity.magnitude > health) {
            Die();
        }
    }
    void Die() {
        Instantiate(deathEffect, transform.position, Quaternion.identity);
        EnemiesAlive--;
        Destroy(gameObject);
        if(EnemiesAlive <= 0) {
            string sceneToLoad = "Quit_Menu";
            switch (GameManager.SceneName)
            {
                case "Level1": {
                    sceneToLoad="Level2";
                    break;
                }
                case "Level2": {
                    sceneToLoad="Level3";
                    break;
                }
            }
            SceneManager.LoadScene(sceneToLoad);
        }
    }
}
