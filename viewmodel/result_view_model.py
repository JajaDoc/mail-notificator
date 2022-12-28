
from PySide2 import QtCore


class ResultViewModel(QtCore.QObject):
    didSendMessage = QtCore.Signal('QVariant')

    def __init__(self):
        super(ResultViewModel, self).__init__()
        self.current_result = None

    @QtCore.Slot(dict, result='QVariant')
    def set_result(self, result):
        self.current_result = result

    @QtCore.Slot(str, str, result='QVariant')
    def set_manual_result(self, to_name, to_address):
        self.current_result = (to_name, to_address, self.current_result[2], self.current_result[3])

    @QtCore.Slot(result='QVariant')
    def get_to_name(self):
        name = self.current_result[0]
        if name is None or len(name) == 0:
            name = "不明"
        return name

    @QtCore.Slot(result='QVariant')
    def on_click_positive_button(self):
        to_name = self.current_result[0]
        to_address = self.current_result[1]
        froms = self.current_result[2]
        image_file = self.current_result[3]
        try:
            self.send_message(to_name, to_address, froms, image_file)
        except Exception as e:
            print(e)

        self.didSendMessage.emit(True)


    def send_message(self, to_name, to_address, from_name, image_file):
        print('sending message...')
        # TODO: メールやチャットへの通知
