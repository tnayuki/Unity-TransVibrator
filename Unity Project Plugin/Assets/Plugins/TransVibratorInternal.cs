using UnityEngine;
using System.Collections;

public class TransVibratorInternal : MonoBehaviour
{
#if UNITY_EDITOR_OSX || UNITY_STANDALONE_OSX
		void OnDestroy ()
		{
				TransVibrator.DeinitializePlugin ();
		}
#endif
}
