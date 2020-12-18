using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Ball3D : MonoBehaviour {
    public Rigidbody rb;
    public Rigidbody hook;
    public SpringJoint joint;
    public GameObject nextBall;
    public GameObject deathEffect;
    public CameraShake cameraShake;
    private float releaseTime=0.3f;
    private float maxDragDistance=30f;
    private float lerpTime=1.0f;
    private bool isPressed=false;
    private bool flag=false;
    void Update() {
        if(!flag && rb.position == hook.position) {
            flag=true;
            joint.connectedBody=rb;
        }
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
       FindObjectOfType<Audiomanager>().Play("BallClick");
    }
    void OnMouseUp() {
        isPressed=false;
        rb.isKinematic=false;
        FindObjectOfType<Audiomanager>().Play("Flying");
        StartCoroutine(Release());
    }
    IEnumerator OnCollisionEnter(Collision colInfo) {
        if (colInfo.collider.name != "Ground") {
            FindObjectOfType<Audiomanager>().Play("BallBoom");
            StartCoroutine(cameraShake.shake(0.35f, 0.4f));
            transform.localScale = new Vector3(transform.localScale.x * 1.5f, transform.localScale.y*1.5f,  transform.localScale.z*1.5f);
            yield return new WaitForSeconds(0.01f);
            transform.localScale = new Vector3(transform.localScale.x / 1.5f, transform.localScale.y/1.5f,  transform.localScale.z/1.5f);
        }
    }
    IEnumerator Release() {
        yield return new WaitForSeconds(releaseTime);
        this.enabled=false;
        joint.connectedBody=null;
        rb.useGravity=true;
        yield return new WaitForSeconds(10f);
        if (nextBall != null) {
             nextBall.GetComponent<Rigidbody>().isKinematic=true;
            float elapsedTime=0f;
            Vector3 currentPosition =  nextBall.GetComponent<Rigidbody>().position;
            Vector3 endPosition = hook.position;
            while(elapsedTime < lerpTime) {
                nextBall.GetComponent<Rigidbody>().position=Vector3.Lerp(currentPosition, endPosition, elapsedTime/lerpTime);
                elapsedTime += Time.deltaTime;
                yield return null;
            }
            nextBall.GetComponent<Rigidbody>().position=endPosition;
            nextBall.GetComponent<Rigidbody>().isKinematic=false;
            Destroy(gameObject);
            Instantiate(deathEffect, transform.position, Quaternion.identity);
            FindObjectOfType<Audiomanager>().Play("BallBoom");
        }
        else {
            Enemy3D.enemiesAlive=0;
            Score.points=0;
            SceneManager.LoadScene("Lose_menu");
        }
    }
}
