Class {
	#name : #LuiOption,
	#superclass : #LuiInputComponent,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #rendering }
LuiOption >> renderComponentOn: html [
	html option
		selected: false;
		label: self;
		value: self
]
