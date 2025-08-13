function varargout = histogram_equlization(varargin)
% HISTOGRAM_EQULIZATION MATLAB code for histogram_equlization.fig
%      HISTOGRAM_EQULIZATION, by itself, creates a new HISTOGRAM_EQULIZATION or raises the existing
%      singleton*.
%
%      H = HISTOGRAM_EQULIZATION returns the handle to a new HISTOGRAM_EQULIZATION or the handle to
%      the existing singleton*.
%
%      HISTOGRAM_EQULIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTOGRAM_EQULIZATION.M with the given input arguments.
%
%      HISTOGRAM_EQULIZATION('Property','Value',...) creates a new HISTOGRAM_EQULIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before histogram_equlization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to histogram_equlization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help histogram_equlization

% Last Modified by GUIDE v2.5 23-May-2025 19:46:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @histogram_equlization_OpeningFcn, ...
                   'gui_OutputFcn',  @histogram_equlization_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before histogram_equlization is made visible.
function histogram_equlization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to histogram_equlization (see VARARGIN)

% Choose default command line output for histogram_equlization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes histogram_equlization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = histogram_equlization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Jiahao Zhou
%20250523

[filename,pathname]= uigetfile('*.*',"选取一副图像");
if isequal(filename,0)||isequal(pathname,0)
    disp('取消选择，程序结束')
    image = zeros(3,3);
    return;
else 
    path = fullfile(pathname,filename);
    image = imread(path);
    if size(image,3) == 3
        image = rgb2gray(image);
    end
end

axes(handles.axes1);
imshow(image);

[x,y,l] = size(image);
num = x*y;

proportion_before_1 = imhist(image);
proportion_before = proportion_before_1/num;

axes(handles.axes1);
imshow(image);

axes(handles.axes3);
bar(proportion_before);
xlabel('灰度级');
ylabel('比例');

handles.image = image;
handles.num = num;
handles.proportion_before = proportion_before;
guidata(hObject,handles);





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Jiahao Zhou
%20250523

image = handles.image;
num = handles.num;
proportion_before = handles.proportion_before;

proportion_mid = zeros(256,1);
for i =1:256
    for j =1:i
        proportion_mid(i,1) = proportion_mid(i,1) + proportion_before(j,1);
    end
end

proportion_now = zeros(256,1);

for i = 1:256
    proportion_now(ceil(proportion_mid(i)*255),1) = ...
    proportion_now(ceil(proportion_mid(i)*255),1)+ proportion_before(i);
end


image_1 = histeq(image);
% proportion_now = imhist(image_1)/num;
axes(handles.axes2)
imshow(image_1);

axes(handles.axes4);
bar(proportion_now);
xlabel('灰度级');
ylabel('比例');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3

set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'box','on');


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4

set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'box','on');
