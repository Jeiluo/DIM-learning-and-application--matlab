function varargout = image_rotation(varargin)
% IMAGE_ROTATION MATLAB code for image_rotation.fig
%      IMAGE_ROTATION, by itself, creates a new IMAGE_ROTATION or raises the existing
%      singleton*.
%
%      H = IMAGE_ROTATION returns the handle to a new IMAGE_ROTATION or the handle to
%      the existing singleton*.
%
%      IMAGE_ROTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_ROTATION.M with the given input arguments.
%
%      IMAGE_ROTATION('Property','Value',...) creates a new IMAGE_ROTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_rotation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_rotation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_rotation

% Last Modified by GUIDE v2.5 23-May-2025 16:21:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_rotation_OpeningFcn, ...
                   'gui_OutputFcn',  @image_rotation_OutputFcn, ...
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


% --- Executes just before image_rotation is made visible.
function image_rotation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_rotation (see VARARGIN)

% Choose default command line output for image_rotation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_rotation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = image_rotation_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on slider movement.

function slider1_Callback(hObject, eventdata, handles)

set(handles.slider1,'Min',0,'Max',360);
angle = get(hObject,'Value');
image = handles.image_1;

R = [cos(angle),-sin(angle),0;sin(angle),cos(angle),0;0,0,1];

% [h,w,~] = size(image);
% for i =1:h
%     for j =1:w
%         x = [j;i;1];
%         new_x = R*x;
%         new_j = round(new_x(1));
%         new_i = round(new_x(2));
%         if new_i>=1&&new_i<=h&&new_j>=1&&new_j<=w
%             rotated(i,j,:) = image(new_i,new_j,:);
%         end
%     end
% end

rotated = imrotate(image,angle);
imshow(rotated,'Parent',handles.axes2);

handles.rotated = rotated;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Jiahao Zhou
%20250523
[filename_1,pathname_1]= uigetfile('*.*',"选取一副图像");
if isequal(filename_1,0)||isequal(pathname_1,0)
    disp('取消选择，程序结束')
    image_1 = zeros(3,3);
    return;
else 
    path_1 = fullfile(pathname_1,filename_1);
    image_1 = imread(path_1);
end

axes(handles.axes1);
imshow(image_1);

handles.image_1 = image_1;
guidata(hObject,handles);



% --- Executes on button press in pushbutton2.

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
