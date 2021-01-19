using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class bricksprefab : MonoBehaviour
{
    // Start is called before the first frame update
    void Start() {
        StartCoroutine(MoveBrickPrefab(1f, transform.position, transform.position - 2*Vector3.up));
    }
    IEnumerator MoveBrickPrefab(float lerpTime, Vector3 currentPosition, Vector3 endPosition) {
        float elapsedTime=0f;
        while(elapsedTime < lerpTime) {
            transform.position=Vector3.Lerp(currentPosition, endPosition, elapsedTime/lerpTime);
            //Debug.Log(Vector3.Lerp(currentPosition, endPosition, elapsedTime/lerpTime));
            elapsedTime += Time.deltaTime;
            yield return null;
        }
        transform.position=endPosition;
    }
}
