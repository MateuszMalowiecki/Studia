using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Ball3D : MonoBehaviour {
    public Rigidbody rb;
    public Rigidbody hook;
    public Joint joint;
    private float releaseTime=0.3f;
    private float maxDragDistance=30f;
    private bool isPressed=false;
    void Update() {
        if(isPressed) {
           Camera camera=Camera.main;
           Vector3 mousePos=camera.ScreenToWorldPoint(new Vector3(Input.mousePosition.x,
 Input.mousePosition.y, camera.transform.position.z));
           if(Vector3.Distance(mousePos, hook.position) > maxDragDistance) {
                rb.position = hook.position + (mousePos - hook.position).normalized * maxDragDistance;
           }
           else {
            rb.position=new Vector3(rb.position.x, mousePos.y, mousePos.z);
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
        Destroy(joint);
        rb.useGravity=true;
        yield return new WaitForSeconds(10f);
        SceneManager.LoadScene("Lose_menu");
    }
}
