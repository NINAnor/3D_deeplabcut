# Step by step 3d multianimal visualisation with DeepLabCut

This repo is a shorter documentation of [3D DeepLabCut](https://deeplabcut.github.io/DeepLabCut/docs/Overviewof3D.html)

## Pull a docker image of DLC:

```
docker pull deeplabcut/deeplabcut:2.3.5-base-cuda11.7.1-cudnn8-runtime-ubuntu20.04-latest 
```

## Run the dlc container & run python inside the container:

Enter the container:

```
./run_dlc.sh
```

Correct the version of `numpy`, otherwise it messes up with a library at `triangulate`

```
pip install numpy=1.22
```

Enter the python environment in the container:

```
python3
```

## Import the DLC module in python:

``` 
import deeplabcut
```

## Create the calibration images:

```
deeplabcut.calibrate_cameras("/host/analysis_cam2_cam3/config.yaml", cbrow=3, cbcol=6, calibrate=False, alpha=0.5)
```

Then rerun with

```
deeplabcut.calibrate_cameras("/host/analysis_cam2_cam3/config.yaml", cbrow=3, cbcol=6, calibrate=True, alpha=0.5)
```

## Check for undistortion

```
deeplabcut.check_undistortion("/host/analysis_cam2_cam3/config.yaml", cbrow=3, cbcol=6)
```

## Triangulate:

:warning: You will get the error `UnboundLocalError: local variable 'putativecam2name' referenced before assignment` IF your videos do not have a suffix or prefix.
So far we have been working with the names `camera-01` and `camera-04` because we calibrate the **CAMERAS** and not the **VIDEOS**.

`deeplabcut.triangulate` first **predicts** the pose in the videos (hence why we need a suffix or prefix). And then create triangulation files for each pair of videos.

```
deeplabcut.triangulate("/host/analysis_cam2_cam3/config.yaml", "/host/analysis_cam1_cam4/videos/", filterpredictions=True, gputouse=1,save_as_csv=True)
```

It's also possible to feed in specific videos we want to analyze instead of the single path.

## Create the 3d video:

```
deeplabcut.create_labeled_video_3d("/host/analysis_cam1_cam4/config.yaml", ["/host/analysis_cam1_cam4/videos"], start=4800, end=5300, videotype=".avi", xlim=(0,10), ylim=(-30,-10), zlim=(10,30))
```

