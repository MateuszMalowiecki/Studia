using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public static string SceneName;
    void Start() {
        SceneName=SceneManager.GetActiveScene().name;
    }
}
