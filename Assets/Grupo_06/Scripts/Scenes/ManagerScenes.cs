using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ManagerScenes : MonoBehaviour
{
    private ManagerScenes Instance;

    private void Awake()
    {
        if(Instance != null)
            Destroy(this);

        Instance = this;

        DontDestroyOnLoad(Instance);
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            LoadNextScene();
        }

        if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            LoadPreviousScene();
        }
    }

    void LoadNextScene()
    {
        int currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
        int nextSceneIndex = currentSceneIndex + 1;

        if (nextSceneIndex < SceneManager.sceneCountInBuildSettings)
        {
            SceneManager.LoadScene(nextSceneIndex);
        }
    }

    void LoadPreviousScene()
    {
        int currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
        int prevSceneIndex = currentSceneIndex - 1;

        if (prevSceneIndex >= 0)
        {
            SceneManager.LoadScene(prevSceneIndex);
        }
    }
}
