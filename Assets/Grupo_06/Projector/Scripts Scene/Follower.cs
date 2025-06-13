using UnityEngine;

public class Follower : MonoBehaviour
{
    public Transform target; 
    private Vector3 offset;

    void Start()
    {
        if (target == null) return;
        offset = transform.position - target.position;
    }

    void LateUpdate()
    {
        if (target == null) return;
        transform.position = target.position + offset;
    }
}
