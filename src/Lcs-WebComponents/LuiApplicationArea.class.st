Class {
	#name : #LuiApplicationArea,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #defaults }
LuiApplicationArea >> defaultCssClasses [
	^ OrderedCollection with: 'applicationArea'
]

{ #category : #rendering }
LuiApplicationArea >> renderApplicationAreaContentOn: html [

	html paragraph: self class name
]

{ #category : #rendering }
LuiApplicationArea >> renderComponentOn: html [
	html div
		id: self componentId;
		class: self cssClassesString;
		dataName: self componentName;
		dataStClass: self;
		with: [self renderApplicationAreaContentOn: html ]
]
