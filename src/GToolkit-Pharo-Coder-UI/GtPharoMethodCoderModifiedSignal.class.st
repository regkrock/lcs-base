Class {
	#name : #GtPharoMethodCoderModifiedSignal,
	#superclass : #GtPharoMethodCoderAnnouncementSignal,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtPharoMethodCoderModifiedSignal >> methodCoder [
	^ self announcement ifNotNil: #coder
]

{ #category : #accessing }
GtPharoMethodCoderModifiedSignal >> printOneLineContentsOn: arg1 [
	| tmp1 |
	self printOneLineCommunicatorId: arg1.
	self methodCoder ifNil: [ ^ self ].
	self mediator ifNotNil: [ arg1 nextPutAll: ', ' ].
	(tmp1 := self methodCoder selector)
		ifNotNil: [ arg1 nextPutAll: tmp1 asString ]
]
