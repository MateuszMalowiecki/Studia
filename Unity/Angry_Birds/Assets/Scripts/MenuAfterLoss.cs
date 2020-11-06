using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuAfterLoss : MonoBehaviour {
   private void OnMouseDown() {
        SceneManager.LoadScene("Menu");
    } 
}
