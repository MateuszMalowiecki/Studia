using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bricks : MonoBehaviour {
    public GameObject brickParticle;
    public GameObject nextBrick;
    public int hitPoints=1;
    void OnCollisionEnter(Collision other) {
        GameManager.instance.pointsFromLevel += this.hitPoints * 20;
        GameManager.instance.setText();
        this.hitPoints--;
        float buffSpawnChance = UnityEngine.Random.Range(0, 100f);
        float deBuffSpawnChance = UnityEngine.Random.Range(0, 100f);

        if (buffSpawnChance <= CollectableManager.instance.BuffChance) {
            Collectables newBuff = this.SpawnCollectable(true);
        }

        /*else if (deBuffSpawnChance <= CollectableManager.instance.DebuffChance)
        {
            Collectables newDebuff = this.SpawnCollectable(false);
        }*/
        if (hitPoints == 0) {
            Instantiate(brickParticle, transform.position, Quaternion.identity);
            Destroy(gameObject);
            GameManager.instance.DestroyBrick();
        }
        else{
            Instantiate(nextBrick, transform.position, Quaternion.identity);
            Destroy(gameObject);
        }
    }
    private Collectables SpawnCollectable(bool isBuff) {
        List<Collectables> collection;

        if (isBuff)
        {
            collection = CollectableManager.instance.AvailableBuffs;
        }
        else
        {
            collection = CollectableManager.instance.AvailableDebuffs;
        }

        int buffIndex = UnityEngine.Random.Range(0, collection.Count);
        Collectables prefab = collection[buffIndex];
        Collectables newCollectable = Instantiate(prefab, this.transform.position, Quaternion.identity) as Collectables;
        //newCollectable.rigibdbody.useGravity=true;
        return newCollectable;
    }
}
