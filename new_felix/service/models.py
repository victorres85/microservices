from sqlalchemy import create_engine, Column, Integer, Date
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import func

Base = declarative_base()

class ViewsCounter(Base):
    __tablename__ = 'views_counter'
    id = Column(Integer, primary_key=True)
    timestamp = Column(Date, default=func.now())
    home_viewers = Column(Integer, default=0)
    form_viewers = Column(Integer, default=0)
    quiz_viewers = Column(Integer, default=0)
    result_viewers = Column(Integer, default=0)
    upload_cat_viewers = Column(Integer, default=0)

engine = create_engine('sqlite:///yourdatabase.db')
Base.metadata.create_all(engine)