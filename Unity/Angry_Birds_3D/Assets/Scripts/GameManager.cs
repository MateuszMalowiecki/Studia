using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public static string SceneName;
    // Start is called before the first frame update
    void Start() {
        SceneName=SceneManager.GetActiveScene().name;
    }
}
