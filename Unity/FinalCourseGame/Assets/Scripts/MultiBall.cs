using UnityEngine;

//Klasa docelowo miała za zadanie tworzyć dodatkowe piłeczki,
//na razie jednak jedyne co ona robi to dodaje jakieś dodatkowe punkty za dany poziom
public class MultiBall : Collectables {
    protected override void ApplyEffect() {
      GameManager.instance.pointsFromLevel += 10;
      GameManager.instance.setPointsText();
    }
}
