
from logging import getLogger

from PySide2 import QtCore

PAGE_CAMERA = 0
PAGE_RESULT = 1
PAGE_MEMBERS = 2


class MainViewModel(QtCore.QObject):
    screenChanged = QtCore.Signal(int)
    onChangedVisibleStateCameraPage = QtCore.Signal(bool)
    onCompleteSendMessage = QtCore.Signal(bool)

    def __init__(self):
        super(MainViewModel, self).__init__()
        self.current_screen = 0

    @QtCore.Slot(result='QVariant')
    def current_page(self):
        return self.current_screen

    @QtCore.Slot(result='QVariant')
    def on_complete_ocr(self):
        self.current_screen = PAGE_RESULT
        self.screenChanged.emit(self.current_screen)
        self.onChangedVisibleStateCameraPage.emit(False)
        return self.current_screen

    @QtCore.Slot(result='QVariant')
    def on_complete_send_message(self):
        self.current_screen = PAGE_CAMERA
        self.screenChanged.emit(self.current_screen)
        self.onChangedVisibleStateCameraPage.emit(True)
        return self.current_screen

    @QtCore.Slot(result='QVariant')
    def on_cancel_send_message(self):
        self.current_screen = PAGE_MEMBERS
        self.screenChanged.emit(self.current_screen)
        return self.current_screen

    @QtCore.Slot(result='QVariant')
    def on_selected_member(self):
        self.current_screen = PAGE_RESULT
        self.screenChanged.emit(self.current_screen)
        return self.current_screen

    @QtCore.Slot(result='QVariant')
    def reset(self):
        self.current_screen = PAGE_CAMERA
        self.screenChanged.emit(self.current_screen)
        self.onChangedVisibleStateCameraPage.emit(True)
        return self.current_screen
