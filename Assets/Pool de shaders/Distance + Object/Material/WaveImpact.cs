using UnityEngine;

public class WaveImpact : MonoBehaviour
{
    public Material waveMaterial;

    private void OnTriggerEnter(Collider other)
    {
        // Tomamos el punto más cercano desde el otro objeto hacia este (plano)
        Vector3 contactPoint = other.ClosestPoint(transform.position);

        // Enviamos el punto al shader
        waveMaterial.SetVector("_WaveOrigin", contactPoint);
    }
}