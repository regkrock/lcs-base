Class {
	#name : #GtJob,
	#superclass : #Job,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtJob >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]
]

{ #category : #accessing }
GtJob >> announcer: arg1 [
	announcer := arg1
]
