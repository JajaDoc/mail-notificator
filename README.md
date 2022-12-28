# mail-notificator

従業員宛の郵便物が届いたことを宛先人に通知するアプリケーションです。郵便物をカメラで撮影し、自動で宛先人を判別します。

OCRには[Google Cloud Vision API](https://cloud.google.com/vision)、宛先人の抽出には[spaCy](https://spacy.io/)と[GiNZA](https://megagonlabs.github.io/ginza/)、GUIには[PySide2](https://pypi.org/project/PySide2/)を使用しています。

## Feature

* OCR
* 宛先人抽出
* 宛先人個別選択

## Requirements

* Python 3.9
* pipenv
* Google Cloud Vision API サービスアカウントキー
  + https://cloud.google.com/vision/docs/libraries#setting_up_authentication

## Use Libraries

* google-cloud-vision
* pyside2
* ginza, ja-ginza
* opencv-contrib-python

## Install

```shell
pipenv install
```

## Run

```shell
pipenv run python main.py
```

## Customize

### 従業員名簿

Vision APIでのOCR結果から、GiNZAで固有表現を抽出し、従業員名簿と比較します。
従業員を変更したい場合は、`data/members.csv`を書き換えてください。

### 通知方法

宛先人への通知方法は、メールやチャットなど好きなものを設定してください。
`viewmodel/result_view_model.py`の`send_message`内に処理を追加してください。

## LICENSE

This software is released under the MIT License, see LICENSE.txt.

---

* https://qiita.com/taiwa_tky/items/05eba3b276fbbea017cb
