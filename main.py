import os
import sys

from PySide2 import QtCore, QtWidgets, QtQml

from repository.member import MembersRepository
from repository.gcp_vision import GCPVisionRepository
from ui.view.camera_view import CameraView
from viewmodel.camera_view_model import CameraViewModel
from viewmodel.main_view_model import MainViewModel
from viewmodel.members_view_model import MembersViewModel
from viewmodel.result_view_model import ResultViewModel


def qt_message_handler(mode, context, message):
    if mode == QtCore.QtInfoMsg:
        mode = 'Info'
    elif mode == QtCore.QtWarningMsg:
        mode = 'Warning'
    elif mode == QtCore.QtCriticalMsg:
        mode = 'critical'
    elif mode == QtCore.QtFatalMsg:
        mode = 'fatal'
    else:
        mode = 'Debug'
    print("%s: %s (%s:%d, %s)" % (mode, message, context.file, context.line, context.file))


print("Start Application.")
members_repository = MembersRepository('data/members.csv')
gcp_vision_repository = GCPVisionRepository()
main_view_model = MainViewModel()
camera_view_model = CameraViewModel(members_repository, gcp_vision_repository)
result_view_model = ResultViewModel()
members_view_model = MembersViewModel(members_repository)

# Set the QtQuick Style
# Acceptable values: Default, Fusion, Imagine, Material, Universal.
os.environ['QT_QUICK_CONTROLS_STYLE'] = (sys.argv[1]
                                         if len(sys.argv) > 1 else "Default")
os.environ['QT_QUICK_CONTROLS_STYLE'] = 'Material'

QtCore.qInstallMessageHandler(qt_message_handler)

# Create an instance of the application
# QApplication MUST be declared in global scope to avoid segmentation fault
app = QtWidgets.QApplication(sys.argv)

# Create QML engine
engine = QtQml.QQmlApplicationEngine()

ctx = engine.rootContext()
QtQml.qmlRegisterType(CameraView, 'CameraView', 1, 0, 'CameraView')
ctx.setContextProperty("MainViewModel", main_view_model)
ctx.setContextProperty("CameraViewModel", camera_view_model)
ctx.setContextProperty("ResultViewModel", result_view_model)
ctx.setContextProperty("MembersViewModel", members_view_model)

# Load the qml file into the engine
engine.load(QtCore.QUrl('ui/qml/Main.qml'))

# Qml file error handling
if not engine.rootObjects():
    print("rootObjects is None!")
    sys.exit(-1)

sys.exit(app.exec_())
