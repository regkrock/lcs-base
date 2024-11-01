Class {
	#name : #LuiForNameProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constants }
LuiForNameProperty class >> propertyName [
	^ 'forName'
]

{ #category : #accessing }
LuiForNameProperty >> for: aString [
	self valueBlock: [ aString ]
]
