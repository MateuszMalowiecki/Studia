using UnityEngine;
using UnityEngine.SceneManagement;

public class GoToNextLevel : MonoBehaviour {
    private void OnMouseDown() {
        if (GameManager.SceneName == "3DLevel") {
            SceneManager.LoadScene("3DLevel2");
        }
        else {
            SceneManager.LoadScene("3DLevel3");
        }
    }
}
