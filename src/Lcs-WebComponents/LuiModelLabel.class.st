Class {
	#name : #LuiModelLabel,
	#superclass : #LuiLabel,
	#category : #'Lcs-WebComponents-Widgets'
}

{ #category : #label }
LuiModelLabel >> labelString [
	^ self valueAccessor label
]
