using UnityEngine;

public class HologramSpawner : MonoBehaviour
{
    public GameObject prefab;
    public Material materialHolograma;
    public Material materialFinal;
    public float tiempoDeTransicion = 2f;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            GameObject instancia = Instantiate(prefab, transform.position, Quaternion.identity);
            StartCoroutine(TransicionHolograma(instancia));
        }
    }

    private System.Collections.IEnumerator TransicionHolograma(GameObject objeto)
    {
        Renderer rend = objeto.GetComponent<Renderer>();
        rend.material = materialHolograma;

        // Pod�s meter una animaci�n de escala o ruido si quer�s, mientras se ve el holograma

        yield return new WaitForSeconds(tiempoDeTransicion);

        rend.material = materialFinal;
    }
}