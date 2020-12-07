using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

//TODO: Points API
public class Ball3D : MonoBehaviour {
    public Rigidbody rb;
    public Rigidbody hook;
    public Joint joint;
    public GameObject nextBall;
    public CameraShake cameraShake;
    public Audiomanager manager;
    public GameObject obstacleBoom;
    private float releaseTime=0.2f;
    private float maxDragDistance=30f;
    //private float lerpTime=1.0f;
    private bool isPressed=false;
    //private bool jumping=true;
    void Update() {
        /*if (jumping && rb.position != hook.position) {
            StartCoroutine(Jump());
        }*/
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
       //jumping = false;
       isPressed=true;
       rb.isKinematic=true;
       FindObjectOfType<Audiomanager>().Play("BallClick");
    }
    void OnMouseUp() {
        isPressed=false;
        rb.isKinematic=false;
        FindObjectOfType<Audiomanager>().Play("Flying");
        StartCoroutine(Release());
    }
    void OnCollisionEnter(Collision colInfo) {
       //Instantiate(obstacleBoom, transform.position, Quaternion.identity);
        FindObjectOfType<Audiomanager>().Play("BallBoom");
        StartCoroutine(cameraShake.shake(0.35f, 0.4f));
    }
    IEnumerator Release() {
        yield return new WaitForSeconds(releaseTime);
        Destroy(joint);
        rb.useGravity=true;
        yield return new WaitForSeconds(10f);
        if (nextBall != null) {
            /*
            nextBall.GetComponent<Rigidbody>().isKinematic=true;
            float elapsedTime=0f;
            Vector3 currentPosition =  nextBall.GetComponent<Rigidbody>().position;
            Vector3 endPosition = hook.position;
            while(elapsedTime < lerpTime) {
                nextBall.GetComponent<Rigidbody>().position=Vector3.Lerp(currentPosition, endPosition, elapsedTime/lerpTime);
                elapsedTime += Time.deltaTime;
                yield return null;
            }
            nextBall.GetComponent<Rigidbody>().position=endPosition;*/
            nextBall.SetActive(true);
        }
        else {
            Enemy3D.enemiesAlive=0;
            Score.points=0;
            SceneManager.LoadScene("Lose_menu");
        }
    }
    /*IEnumerator Jump() {
        nextBall.GetComponent<Rigidbody>().isKinematic=true;
        float elapsedTime=0f;
        Vector3 currentPosition =  rb.position;
        Vector3 endPosition = currentPosition + Vector3.up;
        while(elapsedTime < lerpTime) {
            rb.position=Vector3.Lerp(currentPosition, endPosition, elapsedTime/lerpTime);
            elapsedTime += Time.deltaTime;
            yield return null;
        }
        rb.position=endPosition;
        while(elapsedTime < lerpTime) {
            rb.position=Vector3.Lerp(endPosition, currentPosition, elapsedTime/lerpTime);
            elapsedTime += Time.deltaTime;
            yield return null;
        }
        rb.position=currentPosition;
        //nextBall.GetComponent<Rigidbody>().isKinematic=false;        
    }*/
}
