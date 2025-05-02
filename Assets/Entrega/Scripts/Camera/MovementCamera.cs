using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovementCamera : MonoBehaviour
{
    [Header("Movement Settings")]
    [SerializeField] private float movementSpeed = 10f;
    [SerializeField] private float fastSpeedMultiplier = 2f;
    [SerializeField] private float slowSpeedMultiplier = 0.5f;
    [SerializeField] private float lookSpeed = 2f;

    private float yaw = 0f;
    private float pitch = 0f;

    void Update()
    {
        HandleMouseLook();
        HandleMovement();
    }

    void HandleMouseLook()
    {
        if (Input.GetMouseButton(1))
        {
            Cursor.lockState = CursorLockMode.Locked;
            yaw += lookSpeed * Input.GetAxis("Mouse X");
            pitch -= lookSpeed * Input.GetAxis("Mouse Y");
            pitch = Mathf.Clamp(pitch, -90f, 90f);

            transform.eulerAngles = new Vector3(pitch, yaw, 0.0f);
        }
        else
        {
            Cursor.lockState = CursorLockMode.None;
        }
    }

    void HandleMovement()
    {
        float speed = movementSpeed;

        if (Input.GetKey(KeyCode.LeftShift))
            speed = fastSpeedMultiplier;
        if (Input.GetKey(KeyCode.LeftControl))
            speed = slowSpeedMultiplier;

        Vector3 move = Vector3.zero;
        move += transform.forward * Input.GetAxis("Vertical");
        move += transform.right * Input.GetAxis("Horizontal");

        if (Input.GetKey(KeyCode.E))
            move += transform.up;
        if (Input.GetKey(KeyCode.Q))
            move -= transform.up;

        transform.position += move * speed * Time.deltaTime;
    }

}
