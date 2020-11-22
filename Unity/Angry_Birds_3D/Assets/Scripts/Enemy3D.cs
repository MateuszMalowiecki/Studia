using UnityEngine;
using UnityEngine.SceneManagement;

public class Enemy3D : MonoBehaviour {
    public float health=4f;
    void OnCollisionEnter(Collision colInfo) {
        if (colInfo.relativeVelocity.magnitude > health) {
            Die();
        }
    }
    void Die() {
        Destroy(gameObject);
        string sceneToLoad = "Quit_Menu";
        switch (GameManager.SceneName) {
            case "3DLevel": {
                sceneToLoad="3DLevel2";
                break;
            }
            case "3DLevel2": {
                sceneToLoad="3DLevel3";
                break;
            }
        }
        SceneManager.LoadScene(sceneToLoad);
    }
}
