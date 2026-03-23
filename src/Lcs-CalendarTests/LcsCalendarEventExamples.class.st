Class {
	#name : 'LcsCalendarEventExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-CalendarTests-Examples',
	#package : 'Lcs-CalendarTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsCalendarEventExamples >> newEvent [
	<gtExample>
	| event |
	LcsCalendarEvent hasSlotModel ifFalse: [ self ensureCurrentSystemIsDemoSystem ].
	event := LcsCalendarEvent new.
	self assert: (event effective isKindOf: DateAndTime).
	self assert: (event expiry isKindOf: DateAndTime).
	self assert: event effective < event expiry.
	self assert: event effective year equals: event expiry year.
	self assert: event effective month equals: event expiry month.
	self assert: event effective dayOfMonth equals: event expiry dayOfMonth.
	self assert: event effective hour + 1 equals: event expiry hour.
	self assert: event effective minute equals: event expiry minute.
	self assert: event effective minute equals: 0.
	self assert: event effective seconds equals: 0.
	self assert: event title equals: ''.
	self assert: event description equals: ''.
	self should: [ event description: 123 ] raise: LcsError.
	^ event
]
