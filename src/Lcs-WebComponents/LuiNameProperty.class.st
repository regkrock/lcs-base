Class {
	#name : #LuiNameProperty,
	#superclass : #LuiComponentProperty,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #constants }
LuiNameProperty class >> propertyName [
	^ 'name'
]

{ #category : #accessing }
LuiNameProperty >> name: aString [
	self valueBlock: [ aString ]
]
