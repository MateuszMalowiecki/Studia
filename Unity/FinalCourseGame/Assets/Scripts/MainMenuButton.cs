using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenuButton : MonoBehaviour {
    private void OnMouseDown() {
        SceneManager.LoadScene("MainMenu");
    } 
}
