using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuAfterLoss : MonoBehaviour {
   private void OnMouseDown() {
        Score.pointSum=0;
        SceneManager.LoadScene("Menu");
    } 
}
