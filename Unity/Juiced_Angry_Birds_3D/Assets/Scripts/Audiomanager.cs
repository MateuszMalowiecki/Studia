using System;
using UnityEngine.Audio;
using UnityEngine;

public class Audiomanager : MonoBehaviour
{
    public Sound[] sounds;
    void Awake() {
        foreach(Sound s in sounds) {
            s.source= gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;
        }
    }
    public void Play(String sound) {
        Sound s = Array.Find(sounds, item => item.name == sound);
        if (s == null) {
			Debug.LogWarning("Sound: " + sound + " not found!");
			return;
		}
        //s.source.volume = s.volume * (1f + UnityEngine.Random.Range(-s.volumeVariance / 2f, s.volumeVariance / 2f));
		//s.source.pitch = s.pitch * (1f + UnityEngine.Random.Range(-s.pitchVariance / 2f, s.pitchVariance / 2f));
        s.source.time=s.source.clip.length * .2f;
		s.source.Play();
    }
}
