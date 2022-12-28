
import datetime
import os

import cv2
import qimage2ndarray
import numpy as np
from PySide2 import QtCore, QtQuick


class Singleton(type(QtCore.QObject), type):
    def __init__(cls, name, bases, dict):
        super().__init__(name, bases, dict)
        cls.instance = None

    def __call__(cls, *args, **kw):
        if cls.instance is None:
            cls.instance = super().__call__(*args, **kw)
        return cls.instance


class CameraView(QtQuick.QQuickPaintedItem, metaclass=Singleton):

    def __init__(self):
        super(CameraView, self).__init__()
        self.is_visible = True
        self.video_size = QtCore.QSize(1280, 720)
        self._canvas = np.zeros((720, 1280, 3), dtype=np.uint8)
        self.capture = None
        self.current_frame = None
        self.init_camera()

    def __del__(self):
        self.capture.release()

    def get_camera_capture(self):
        for num in range(0, 10):
            cap = cv2.VideoCapture(num, apiPreference=cv2.CAP_DSHOW)
            ret, _ = cap.read()
            if ret is True:
                print("camera_number", num, "Find!")
                print(f"set CAP_PROP_FRAME_WIDTH={self.video_size.width()}",
                      cap.set(cv2.CAP_PROP_FRAME_WIDTH, self.video_size.width()))
                print(f"set CAP_PROP_FRAME_HEIGHT={self.video_size.height()}",
                      cap.set(cv2.CAP_PROP_FRAME_HEIGHT, self.video_size.height()))
                return cap
            else:
                print("camera_number", num, "None")
                exec("1")

    def init_camera(self):
        self.capture = self.get_camera_capture()

    def paint(self, painter):
        _, self.current_frame = self.capture.read()
        self.current_frame = cv2.cvtColor(self.current_frame, cv2.COLOR_BGR2RGB)
        image = qimage2ndarray.array2qimage(self.current_frame)
        painter.drawImage(0, 0, image)

    @QtCore.Slot(result='QVariant')
    def save_image(self):
        print('Saving image')
        now = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        filename = f'data/history/{now}.jpg'
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        cv2.imwrite(filename, cv2.cvtColor(self.current_frame, cv2.COLOR_RGB2BGR))
        return filename

    @QtCore.Slot(bool, result='QVariant')
    def on_changed_visible_state(self, is_visible):
        print(f'Changed visible state of camera page. {is_visible}')
        self.is_visible = is_visible
