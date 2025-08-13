function varargout = find_difference(varargin)
%FIND_DIFFERENCE MATLAB code file for find_difference.fig
%      FIND_DIFFERENCE, by itself, creates a new FIND_DIFFERENCE or raises the existing
%      singleton*.
%
%      H = FIND_DIFFERENCE returns the handle to a new FIND_DIFFERENCE or the handle to
%      the existing singleton*.
%
%      FIND_DIFFERENCE('Property','Value',...) creates a new FIND_DIFFERENCE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to find_difference_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FIND_DIFFERENCE('CALLBACK') and FIND_DIFFERENCE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in FIND_DIFFERENCE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help find_difference

% Last Modified by GUIDE v2.5 21-May-2025 18:41:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @find_difference_OpeningFcn, ...
                   'gui_OutputFcn',  @find_difference_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before find_difference is made visible.
function find_difference_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for find_difference
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes find_difference wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = find_difference_OutputFcn(hObject, eventdata, handles)
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
%20250521

[filename_1,pathname_1]= uigetfile('*.*',"选取一副图像");
if isequal(filename_1,0)||isequal(pathname_1,0)
    disp('取消选择，程序结束')
    image_1 = zeros(3,3);
    return;
else 
    path_1 = fullfile(pathname_1,filename_1);
    image_1 = imread(path_1);
end

image_1_grey = rgb2gray(image_1);

axes(handles.axes1);
imshow(image_1);

handles.image_1_grey = image_1_grey;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Jiahao Zhou
%20250521

if ~isfield(handles, 'image_1_grey')
    errordlg('请先加载第一幅图像！', '错误');
    return;
end


[filename_2, pathname_2] = uigetfile('*.*', '选择第二幅图像');
if isequal(filename_2, 0) || isequal(pathname_2, 0)
    disp('用户取消选择第二幅图像');
    return;
end


path_2 = fullfile(pathname_2, filename_2);
image_2 = imread(path_2);
image_2_grey = rgb2gray(image_2);  % 转为灰度图


if ~isequal(size(handles.image_1_grey), size(image_2_grey))
    errordlg('两幅图像尺寸不匹配！', '错误');
    return;
end


subtraction = abs(double(handles.image_1_grey) - double(image_2_grey));
threshold = graythresh(subtraction);
binary = imbinarize(subtraction, threshold);

dilated = imdilate(binary,strel('disk', 3));
[labeled, num_regions] = bwlabel(dilated);
eroded = imerode(labeled, strel('disk', 3));

boxes = regionprops(eroded, 'BoundingBox');

axes(handles.axes2);
imshow(image_2);

for i = 1:num_regions
    rect = boxes(i).BoundingBox;
    rectangle('Position', rect, 'EdgeColor', 'r', 'LineWidth', 2);
end


handles.image_2_grey = image_2_grey;
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

%Jiahao Zhou
%20250521

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