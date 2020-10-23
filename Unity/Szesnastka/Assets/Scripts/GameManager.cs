using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {
    public Piece puzzlePrefab;
    
    private List<Piece> puzzleList = new List<Piece>();
    private List<Vector3> puzzlePosition = new List<Vector3>();
    private List<int> randomNumbers = new List<int>();
    
    private Vector3 startPosition = new Vector3(0.0f, 3.0f, 0.0f);
    
    public LayerMask collisionMask;
    
    Ray ray_up, ray_down, ray_left, ray_right;
    RaycastHit hit;
    
    private BoxCollider boxCollider;
    private Vector3 boxCollider_size;
    private Vector3 boxCollider_center;

    [HideInInspector]
    public static GameStatus gs = new GameStatus();

    // Start is called before the first frame update
    void Start()
    {
        spawnPuzzle(14);
        setStartPosition();
        applyMaterial();
    }

    // Update is called once per frame
    void Update()
    {
        switch(gs.g) {
            case(GameStatus.gameStat.start_pressed):
                MixPuzzles();
                gs.g=GameStatus.gameStat.play;
                break;
            case(GameStatus.gameStat.play):
                if (haveWeWon()) {
                    gs.g=GameStatus.gameStat.win;
                }
                MovePuzzle();
                break;
            case(GameStatus.gameStat.win):
                SceneManager.LoadScene("Scenes/Exit Menu");
                break;

        }
    }
    private void spawnPuzzle(int number) {
        for(int i=0; i <= number; i++) {
            puzzleList.Add(Instantiate(puzzlePrefab, new Vector3(0.0f, 0.0f, 0.0f), new Quaternion(0.0f, 0.0f, 100.0f, 0.0f)) as Piece);
        }
    }
    private void setStartPosition() {
        puzzleList[0].transform.position = startPosition;
        puzzleList[1].transform.position = startPosition + 6*Vector3.right;
        puzzleList[2].transform.position = startPosition + 12*Vector3.right;
        puzzleList[3].transform.position = startPosition + 18*Vector3.right;

        
        puzzleList[4].transform.position = startPosition + 6*Vector3.back;
        puzzleList[5].transform.position = startPosition + 6*Vector3.back + 6*Vector3.right;
        puzzleList[6].transform.position = startPosition + 6*Vector3.back + 12*Vector3.right;
        puzzleList[7].transform.position = startPosition + 6*Vector3.back + 18*Vector3.right;

        
        puzzleList[8].transform.position = startPosition + 12*Vector3.back;
        puzzleList[9].transform.position = startPosition + 12*Vector3.back + 6*Vector3.right;
        puzzleList[10].transform.position = startPosition + 12*Vector3.back + 12*Vector3.right;
        puzzleList[11].transform.position = startPosition + 12*Vector3.back + 18*Vector3.right;

        
        puzzleList[12].transform.position = startPosition + 18*Vector3.back;
        puzzleList[13].transform.position = startPosition + 18*Vector3.back + 6*Vector3.right;
        puzzleList[14].transform.position = startPosition + 18*Vector3.back + 12*Vector3.right;
    }
    void MovePuzzle() {
        foreach(Piece puzzle in puzzleList) {
            if (puzzle.clicked) {
                boxCollider=puzzle.GetComponent<BoxCollider>();
                boxCollider_size=boxCollider.size;
                boxCollider_center=boxCollider.center;
                
                float move_amount = 6;
                float direction=Mathf.Sign(move_amount);
                
                float x=(puzzle.transform.position.x + boxCollider_center.x - boxCollider_size.x / 2) + boxCollider_size.x / 2;
                float y=(puzzle.transform.position.y + boxCollider_center.y - boxCollider_size.y / 2) + boxCollider_size.y / 2;
                float z_up=puzzle.transform.position.z + boxCollider_center.z + boxCollider_size.z / 2 * direction; 
                float z_down=puzzle.transform.position.z + boxCollider_center.z + boxCollider_size.z / 2 * -direction; 
                
                ray_up=new Ray(new Vector3(x, y, z_up), new Vector3(0, 0, direction));
                ray_down=new Ray(new Vector3(x, y, z_down), new Vector3(0, 0, -direction));

                Debug.DrawRay(ray_up.origin, ray_up.direction);
                Debug.DrawRay(ray_down.origin, ray_down.direction);

                float z=(puzzle.transform.position.z + boxCollider_center.z - boxCollider_size.z / 2) + boxCollider_size.z / 2;
                float x_left=puzzle.transform.position.x + boxCollider_center.x + boxCollider_size.x / 2 * direction; 
                float x_right=puzzle.transform.position.x + boxCollider_center.x + boxCollider_size.x / 2 * -direction; 
                
                ray_left=new Ray(new Vector3(x_left, y, z), new Vector3(-direction, 0, 0));
                ray_right=new Ray(new Vector3(x_right, y, z), new Vector3(direction, 0, 0));

                Debug.DrawRay(ray_left.origin, ray_left.direction);
                Debug.DrawRay(ray_right.origin, ray_right.direction);
                if (!puzzle.moved) {
                    if(!Physics.Raycast(ray_up, out hit, 7.0f, collisionMask) && puzzle.transform.position.z < 0) {
                        Debug.Log("Collision Up");
                        puzzle.go_up=true;
                    }
                    if(!Physics.Raycast(ray_down, out hit, 7.0f, collisionMask) && puzzle.transform.position.z > -18) {
                        Debug.Log("Collision Down");
                        puzzle.go_down=true;
                    }
                    if(!Physics.Raycast(ray_left, out hit, 7.0f, collisionMask) && puzzle.transform.position.x > 0) {
                        Debug.Log("Collision Left");
                        puzzle.go_left=true;
                    }
                    if(!Physics.Raycast(ray_right, out hit, 7.0f, collisionMask) && puzzle.transform.position.x < 18) {
                        Debug.Log("Collision Right");
                        puzzle.go_right=true;
                    }
                }
            }
        }
    }
    void applyMaterial() {
        string filePath;
        for(int i=1; i<= puzzleList.Count; i++) {
            filePath = "Puzzles/Cube" + i;
            Texture2D mat = Resources.Load(filePath, typeof(Texture2D)) as Texture2D;
            puzzleList[i-1].GetComponent<Renderer>().material.mainTexture=mat;
        }
    }
    void MixPuzzles() {
        int number;
        foreach(Piece p in puzzleList) {
            puzzlePosition.Add(p.transform.position);
        }
        foreach(Piece p in puzzleList) {
            number = Random.Range(0, puzzleList.Count);
            while(randomNumbers.Contains(number)) {
                number = Random.Range(0, puzzleList.Count);
            }
            randomNumbers.Add(number);
            p.transform.position = puzzlePosition[number];
        }

    }
    bool haveWeWon() {
        foreach(Piece p in puzzleList) {
            if (p.transform.position != p.winPosition) {
                return false;
            }
        }
        return true;
    }
}