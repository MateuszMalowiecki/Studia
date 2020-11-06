using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Ball : MonoBehaviour {
    public Rigidbody2D rb;
    public Rigidbody2D hook;
    private float releaseTime=0.15f;
    private float maxDragDistance=2f;
    private bool isPressed=false;
    public GameObject nextBall;
    void Update() {
        if(isPressed) {
           Camera camera=Camera.main;
           Vector2 mousePos=camera.ScreenToWorldPoint(new Vector3(Input.mousePosition.x,
 Input.mousePosition.y, camera.transform.position.z * -1));
           if(Vector3.Distance(mousePos, hook.position) > maxDragDistance) {
                rb.position = hook.position + (mousePos - hook.position).normalized * maxDragDistance;
           }
           else {
                rb.position=mousePos;
           }
           
        }
    }
    void OnMouseDown() {
       isPressed=true;
       rb.isKinematic=true;
    }
    void OnMouseUp() {
        isPressed=false;
        rb.isKinematic=false;
        StartCoroutine(Release());
    }
    IEnumerator Release() {
        yield return new WaitForSeconds(releaseTime);
        GetComponent<SpringJoint2D>().enabled=false;
        this.enabled=false;
        yield return new WaitForSeconds(5f);
        if(nextBall != null) {
            nextBall.SetActive(true);
        }
        else {
            Enemy.EnemiesAlive = 0;
            SceneManager.LoadScene("Lose_menu");
        }
    }
}
