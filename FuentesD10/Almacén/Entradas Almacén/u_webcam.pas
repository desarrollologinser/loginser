unit u_webcam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VidGrab, sSkinProvider, StdCtrls, sButton, Buttons,
  sSpeedButton, sPanel;

type
  Tf_webcam = class(TForm)
    vid_1: TVideoGrabber;
    cb_vid: TComboBox;
    sknprvdr1: TsSkinProvider;
    sb_start: TsSpeedButton;
    sb_stop: TsSpeedButton;
    sb_capture: TsSpeedButton;
    p_img: TsPanel;
    im_vid: TImage;
    procedure sknprvdr1TitleButtons0MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sknprvdr1TitleButtons1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cb_vidChange(Sender: TObject);
    procedure sb_startClick(Sender: TObject);
    procedure sb_stopClick(Sender: TObject);
    procedure sb_captureClick(Sender: TObject);
    procedure vid_1FrameCaptureCompleted(Sender: TObject; FrameBitmap: TBitmap;
      BitmapWidth, BitmapHeight: Integer; FrameNumber: Cardinal;
      FrameTime: Int64; DestType: TFrameCaptureDest; FileName: string;
      Success: Boolean; FrameId: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    capturado:Boolean;
  end;

var
  f_webcam: Tf_webcam;

implementation

{$R *.dfm}

procedure Tf_webcam.sb_startClick(Sender: TObject);
begin
  vid_1.VideoDevice:=0;
  vid_1.VideoSize:=6;            //1280
  vid_1.StartPreview;
end;

procedure Tf_webcam.sb_stopClick(Sender: TObject);
begin
  vid_1.StopPreview;
end;

procedure Tf_webcam.cb_vidChange(Sender: TObject);
begin
  vid_1.VideoDevice := cb_vid.ItemIndex;
end;

procedure Tf_webcam.sb_captureClick(Sender: TObject);
begin
  vid_1.CaptureFrameTo (fc_TBitmap, '');
  capturado:=true;
end;

procedure Tf_webcam.vid_1FrameCaptureCompleted(Sender: TObject;
  FrameBitmap: TBitmap; BitmapWidth, BitmapHeight: Integer;
  FrameNumber: Cardinal; FrameTime: Int64; DestType: TFrameCaptureDest;
  FileName: string; Success: Boolean; FrameId: Integer);
begin
   case DestType of
      fc_TBitmap: begin
         im_vid.Picture.Bitmap.Assign (FrameBitmap);
         // you can replace the statement above by the faster 2 statements below,
         // because the bitmap is not copied. However be sure not to reuse it several times.
         // (symptom: a black bitmap. In this case use the statement above instead).

         //Image1.Picture.Bitmap.Handle := FrameBitmap.Handle;
         //FrameBitmap.ReleaseHandle;
      end;
   end;
end;

{$REGION 'Ini-Close'}
procedure Tf_webcam.FormCreate(Sender: TObject);
begin
   cb_vid.Items.Text := vid_1.VideoDevices;
   cb_vid.ItemIndex := vid_1.VideoDevice;
   cb_vid.text:=cb_vid.Items[0];
end;

procedure Tf_webcam.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vid_1.StopPreview;
end;

procedure Tf_webcam.sknprvdr1TitleButtons0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  close;
end;

procedure Tf_webcam.sknprvdr1TitleButtons1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.Minimize;               //minimizar
end;
{$ENDREGION}

end.
